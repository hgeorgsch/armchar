/* (C) 2017: Hans Georg Schaathun <georg@schaathun.net> */

package net.schaathun.armchar;

import java.io.OutputStream;
import java.io.IOException;
import java.io.ByteArrayInputStream;
import javax.ws.rs.core.Response;
import java.io.ByteArrayInputStream;

import java.util.List ;

import org.apache.jena.tdb.TDBFactory;
import org.apache.jena.query.Dataset;
import org.apache.jena.query.DatasetFactory;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.InfModel;
import org.apache.jena.reasoner.rulesys.Rule ;
import org.apache.jena.reasoner.rulesys.GenericRuleReasoner ;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.riot.RDFFormat;
import org.apache.jena.query.ReadWrite;
import org.apache.jena.graph.compose.Union;

import org.apache.jena.reasoner.Reasoner;
import org.apache.jena.reasoner.ReasonerRegistry ;
import org.apache.jena.query.ResultSet ;
import org.apache.jena.query.ResultSetFormatter ;

import org.apache.jena.util.FileManager;

// import onsite.classes.OnsiteOntologyNS;
import net.schaathun.armchar.util.Writer ;

import org.apache.jena.riot.JsonLDWriteContext;

public class ArMModel {
   private static ArMModel instance = null;
   private Dataset dataset ;
   private InfModel model ;
   private Reasoner owlR, ourR, ourBR ;
   private Model data ;

   public static String schemaFile = "/opt/payara/serverdata/arm.ttl" ;
   public static String resourcesFile = "/opt/payara/serverdata/resources.ttl" ;
   public static String rulesFile = "/opt/payara/serverdata/logic.rules" ;
   public static String brulesFile = "/opt/payara/serverdata/basic.rules" ;
   public static String tdbLocation = "/opt/payara/tdb" ;

   private ArMModel() {

      this.dataset = TDBFactory.createDataset( tdbLocation);
      this.data = dataset.getDefaultModel();

      // The schema and resources should be kept constant.
      // They are built into the OWL Reasoner
      Model schema = FileManager.get().loadModel(schemaFile);
      FileManager.get().readModel(schema,resourcesFile);
      this.owlR = ReasonerRegistry.getOWLMicroReasoner().bindSchema(schema);

      // The rules file is similarly constant, and gives
      // rise to a general purpose reasoner on top
      List rules = Rule.rulesFromURL("file:" + rulesFile );
      List brules = Rule.rulesFromURL("file:" + brulesFile );
      this.ourBR = new GenericRuleReasoner(brules);
      this.ourR = new GenericRuleReasoner(rules);

      // Finally, we establish the inference models.
      InfModel ourBM = ModelFactory.createInfModel(this.ourBR, data);
      InfModel owlM = ModelFactory.createInfModel(this.owlR, ourBM);
      this.model = ModelFactory.createInfModel(this.ourR, owlM);
   }

   public static ArMModel getInstance() {
      if(instance == null) {
         instance = new ArMModel();
      }
      return instance;
   }
   public static Model getModel() {
      return getInstance().model ;
   }
   public static Dataset getDataset() {
      return getInstance().dataset ;
   }


   public static String construct( String queryString ) {
       return construct( queryString, null ) ;
   }
   public static String construct( String queryString, String frame ) {
	Dataset dataset = getDataset() ;
	Model model = getModel() ;
        Query query = QueryFactory.create(queryString);

        QueryExecution qexec ;
        Model m ;
        dataset.begin(ReadWrite.READ);
        try {
           qexec = QueryExecutionFactory.create(query, model);
           m = qexec.execConstruct();
        } finally {
           dataset.end();
        }

        qexec.close();
	if ( m.isEmpty() ) {
	   System.out.println( "ArMModel.construct: empty model" ) ;
	   return null ;
	}

        OutputStream output = new OutputStream() {
                private StringBuilder string = new StringBuilder();

                @Override
                public void write(int b) throws IOException {
                    this.string.append((char) b);
                }

                public String toString() {
                    return this.string.toString();
                }
        };
        DatasetGraph g = DatasetFactory.create(m).asDatasetGraph();
	if ( frame == null ) { 
               JsonLDWriteContext ctx = new JsonLDWriteContext();
               ctx.setJsonLDContext("{ " + Config.prefixJS_LD + " }");
               Writer.write(output, g,
	          RDFFormat.JSONLD_COMPACT_PRETTY, ctx );
	} else {
               JsonLDWriteContext ctx = new JsonLDWriteContext();
               ctx.setFrame(frame);
               Writer.write(output, g, RDFFormat.JSONLD_FRAME_PRETTY, ctx);
	}
        qexec.close();
	return output.toString();
    }
    public static String select( String queryString ) {
	Dataset dataset = getDataset() ;
	Model model = getModel() ;
        Query query = QueryFactory.create(queryString);


        OutputStream output = new OutputStream() {
                private StringBuilder string = new StringBuilder();

                @Override
                public void write(int b) throws IOException {
                    this.string.append((char) b);
                }

                public String toString() {
                    return this.string.toString();
                }
        };
        dataset.begin(ReadWrite.READ);
        try {
           QueryExecution qexec = QueryExecutionFactory.create(query, model);
           ResultSet results = qexec.execSelect();
           ResultSetFormatter.outputAsJSON(output, results);
           qexec.close();
        } finally {
           dataset.end();
        }

	return output.toString();
    }
      
    public static Response update(String item, String ID, String type) {
        String result = "Success";
	Dataset dataset = getInstance().dataset ;
        Model m = ModelFactory.createDefaultModel();
        m.read(new ByteArrayInputStream(item.getBytes()), null, "JSON-LD");
        dataset.begin(ReadWrite.WRITE);
        try {
            Model data = dataset.getDefaultModel();
            InfModel model = ModelFactory.createRDFSModel(data);
            org.apache.jena.rdf.model.Resource resource = model.getResource( type + "/" + ID);
            resource.removeProperties();
            model.add(m);

            dataset.commit();
        } finally {
            dataset.end();
        }

        return Response
                .status(200)
                .entity(result)
                .build();
    }

    public static Response create(String str) {
	Dataset dataset = getInstance().dataset ;
        Model m = ModelFactory.createDefaultModel();
        m.read(new ByteArrayInputStream(str.getBytes()), null, "JSON-LD");
        dataset.begin(ReadWrite.WRITE);
        try {
            Model data = dataset.getDefaultModel();
            InfModel model = ModelFactory.createRDFSModel(data);
            model.add(m);
            dataset.commit();
        } finally {
            dataset.end();
        }
        return Response
                .status(200)
                .entity("Success")
                .build();
    }

}
