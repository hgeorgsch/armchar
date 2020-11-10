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

@Path("/Character")
public class Character {

    String frame = null ;
       // "{ \"@context\": { " + Config.prefixJS_LD + " },"
       // + "\"@type\" : [ \"arm:Magus\" ] }" ;

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacter(@PathParam("id") String ID) {

        String queryString = Config.prefix
                    + "CONSTRUCT { armchar:" + ID + " ?p1 ?o1 . "
		    + " ?o1 ?p2 ?o2 .  \r\n"
                    + "} WHERE { armchar:" + ID + " ?p1 ?o1 .\r\n"
		    + "   NOT EXISTS { ?p1 rdf:type arm:ignoredProperty }  \r\n"
                    + "  OPTIONAL { ?o1 ?p2 ?o2 .\r\n"
		    + "   NOT EXISTS { ?p2 rdf:type arm:ignoredProperty }  \r\n"
                    + "} \r\n"
                    + "}";
        String result = ArMModel.construct(queryString);
        return Response
                .ok(result)
                .build();
    }

    @GET
    @Path("/{id}/{season}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacter(@PathParam("id") String id,
                                 @PathParam("season") String season ) {

        String rid = "armchar:" + id ;
        String queryString = Config.prefix
                    + "CONSTRUCT { \r\n" 
		    + " ?s ?p1 ?o1 .  \r\n"
		    + " ?o1 ?p2 ?o2 . \r\n"
                    + "} WHERE { \r\n " 
                    + " ?s arm:isCharacter " + rid + " . \r\n"
		    + " ?s arm:atSeasonTime arm:" + season + " . \r\n"
		    + " ?s ?p1 ?o1 . \r\n"
		    + " NOT EXISTS { ?p1 rdf:type arm:ignoredProperty }  \r\n"
                    + "  OPTIONAL { \r\n" 
                    + "     ?o1 ?p2 ?o2 . \r\n" 
		    + "     NOT EXISTS { ?p2 rdf:type arm:ignoredProperty }  \r\n"
                    + " } \r\n"
                    + "}";
        String result = ArMModel.construct(queryString,frame);
        return Response
                .ok(result)
                .build();
    }


}

