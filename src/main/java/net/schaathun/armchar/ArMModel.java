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
   private Reasoner owlR, ourR ;
   private Model data ;

   public static String ontologyFile = "/var/onsite/onsite.ttl" ;
   public static String rulesFile = "/var/onsite/signal.rules" ;

   private ArMModel() {
      // Exists only to defeat instantiation.
      dataset = TDBFactory.createDataset(""); // OnsiteOntologyNS.location);
      dataset.begin(ReadWrite.WRITE);
      try {
         data = dataset.getDefaultModel();
      } finally {
         dataset.end();
      }
      Model schema = FileManager.get().loadModel(ontologyFile);
      this.owlR = ReasonerRegistry.getOWLMicroReasoner().bindSchema(schema);
      List rules = Rule.rulesFromURL("file:" + rulesFile );
      InfModel owlM = ModelFactory.createInfModel(owlR, data);
      this.ourR = new GenericRuleReasoner(rules);
      this.model = ModelFactory.createInfModel(ourR, owlM);
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
        dataset.begin(ReadWrite.WRITE);
        try {
           qexec = QueryExecutionFactory.create(query, model);
           m = qexec.execConstruct();
        } finally {
           dataset.end();
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
               Writer.write(output, g,
	          RDFFormat.JSONLD_COMPACT_PRETTY, null);
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
        dataset.begin(ReadWrite.WRITE);
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
