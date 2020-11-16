package onsite.rest;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;


import java.io.IOException;
import java.io.OutputStream;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;
import org.apache.jena.query.Dataset;

import org.apache.jena.query.ReadWrite;

import org.apache.jena.riot.system.PrefixMap;
import org.apache.jena.riot.system.RiotLib;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.riot.RDFFormat;
import org.apache.jena.tdb.TDBFactory;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.riot.WriterDatasetRIOT;

import org.apache.jena.query.DatasetFactory;
import org.apache.jena.rdf.model.Model;

import net.schaathun.armchar.ArMModel;

@Path("/dump")
public class Dump {

    @GET
    @Produces("application/n-quads")
    public Response dump() {
        String result = getDump( RDFFormat.NQUADS );
        return Response
                .ok(result)
                .build();
    }
    @GET
    @Path("/jsonld")
    @Produces("application/ld+json")
    public Response jsonld() {
        String result = getDump( RDFFormat.JSONLD_COMPACT_PRETTY );
        return Response
                .ok(result)
                .build();
    }
    @GET
    @Path("/jsonld-inf")
    @Produces("application/ld+json")
    public Response jsonldInf() {
        String result = getInfDump( RDFFormat.JSONLD_COMPACT_PRETTY );
        return Response
                .ok(result)
                .build();
    }

    public String getDump( RDFFormat f ) {
        Dataset dataset = ArMModel.getDataset() ;

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
          DatasetGraph g = dataset.asDatasetGraph();
          WriterDatasetRIOT w = RDFDataMgr.createDatasetWriter(f) ;
          PrefixMap pm = RiotLib.prefixMap(g);
          w.write(output, g, pm, null, null);
        } finally {
            dataset.end();
        }
	return output.toString();
    }
    public String getInfDump( RDFFormat f ) {
        Dataset dataset = ArMModel.getDataset() ;
        Model m = ArMModel.getModel() ;

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
           DatasetGraph g = DatasetFactory.create(m).asDatasetGraph();
           WriterDatasetRIOT w = RDFDataMgr.createDatasetWriter(f) ;
           PrefixMap pm = RiotLib.prefixMap(g);
           w.write(output, g, pm, null, null);
        } finally {
            dataset.end();
        }
	return output.toString();
    }
}
