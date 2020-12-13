package net.schaathun.armchar.resources ;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/* To use query parameters we need */
import javax.ws.rs.QueryParam;
import javax.ws.rs.FormParam;
import javax.ws.rs.DefaultValue;

import java.io.IOException;
import java.io.OutputStream;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.core.Response;
import org.apache.jena.query.Dataset;

import org.apache.jena.query.ReadWrite;

import org.apache.jena.query.ResultSet ;
import org.apache.jena.query.ResultSetFormatter ;

import net.schaathun.armchar.ArMModel ;
import net.schaathun.armchar.Config ;

@Path("/Advancement")
public class Advancement {

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacter(@PathParam("id") String ID) {

        String queryString = Config.prefix
                + "CONSTRUCT {"
		+ "    armchar:" + ID + " arm:hasAdvancementList ?adv . "
		+ "    ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . "
		+ "    ?advhead ?p ?o . \n" 
		+ "    ?advhead  arm:advanceTraitList ?list . "
		+ "    ?listRest rdf:first ?head ; rdf:rest ?tail . "
		+ "    ?head ?p1 ?o1 . \n" 
                + "} WHERE {"
                + "  armchar:" + ID + " arm:hasAdvancementList ?adv . "
                + "  OPTIONAL { \n"
                + "    ?adv rdf:rest* ?advlistRest . \n"
                + "    ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . \n"
                + "    ?advhead ?p ?o . \n"
                + "    OPTIONAL { \n"
                + "       ?advhead  arm:advanceTraitList ?list . \n"
                + "       ?list rdf:rest* ?listRest . \n"
                + "       ?listRest rdf:first ?head ; rdf:rest ?tail . \n"
                + "       ?head ?p1 ?o1 . \n"
                + "    } \n"
                + "  } \n"
                + "}";
        String result = ArMModel.construct(queryString);
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }


}

