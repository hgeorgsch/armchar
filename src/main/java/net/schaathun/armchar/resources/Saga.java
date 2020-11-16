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

@Path("/Saga")
public class Saga {


    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacter(@PathParam("id") String ID) {

        String queryString = Config.prefix
                    + "CONSTRUCT { armchar:" + ID + " ?p1 ?o1 . "
		    + " ?o1 arm:hasName ?n .  \r\n"
		    + " ?o1 arm:hasName ?l .  \r\n"
		    + " ?o1 arm:isSeason ?s .  \r\n"
                    + "} WHERE { armchar:" + ID + " ?p1 ?o1 .\r\n"
		    + "  NOT EXISTS { ?p1 rdf:type arm:ignoredProperty }\r\n"
                    + "  OPTIONAL { ?o1 arm:hasName ?n }\r\n"
                    + "  OPTIONAL { ?o1 rdfs:label ?l }\r\n"
                    + "  OPTIONAL { ?o1 arm:isSeason ?s }\r\n"
                    + "}";
        String result = ArMModel.construct(queryString);
        return Response
                .ok(result)
                .build();
    }


}

