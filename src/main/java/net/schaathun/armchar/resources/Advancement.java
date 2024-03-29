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


        String queryString(String ID) {
	   return Config.prefix
                + "CONSTRUCT {"
		+ "    armchar:" + ID + " arm:hasAdvancementList ?adv . "
		+ "    armchar:" + ID + " a ?t . "
		+ "    ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . "
		+ "    ?advhead ?p ?o . \n" 
		+ "    ?advhead  arm:advanceTraitList ?list . "
		+ "    ?listRest rdf:first ?head ; rdf:rest ?tail . "
		+ "    ?head ?p1 ?o1 . \n" 
                + "} WHERE {"
                + "  armchar:" + ID + " arm:hasAdvancementList ?adv . "
		+ "  armchar:" + ID + " a ?t . "
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
	}
        String queryStringLite(String ID) {
	   return Config.prefix
                + "CONSTRUCT {"
		+ "    armchar:" + ID + " arm:hasAdvancementList ?adv . "
		+ "    armchar:" + ID + " a ?t . "
		+ "    ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . "
		+ "    ?advhead ?p ?o . \n" 
                + "} WHERE {"
                + "  armchar:" + ID + " arm:hasAdvancementList ?adv . "
		+ "  armchar:" + ID + " a ?t . "
                + "  OPTIONAL { \n"
                + "    ?adv rdf:rest* ?advlistRest . \n"
                + "    ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . \n"
                + "    ?advhead ?p ?o . \n"
                + "  } \n"
                + "}";
	}

    @GET
    @Path("/unframed/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacter(@PathParam("id") String ID) 
				 throws IOException {
        String result = ArMModel.construct(queryString(ID));
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

    @GET
    @Path("/framed/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getFramed(@PathParam("id") String ID) 
				 throws IOException {
        String frame = Config.getInstance().advancementframe ;
        String result = ArMModel.construct(queryString(ID),frame);
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getLite(@PathParam("id") String ID) 
				 throws IOException {
        String frame = Config.getInstance().advancementframe ;
        String result = ArMModel.construct(queryStringLite(ID),frame);
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

    private String queryStringSeason(String id, int year, String season) {
       return Config.prefix
                + "CONSTRUCT { \r\n" 
		+ " ?adv a arm:CharacterAdvancement . \r\n"
		+ " ?adv ?dp ?dval .  \r\n"
		+ " ?adv ?op ?oval . \r\n"
                + " ?adv ?p ?op . \r\n" 
		+ "    ?adv  arm:advanceTraitList ?list . "
		+ "    ?listRest rdf:first ?head ; rdf:rest ?tail . "
		+ "    ?head ?p1 ?o1 . \n" 
                + "} WHERE { \r\n " 
                + " ?adv arm:advanceCharacter armchar:" + id + " . \r\n"
		+ " ?adv arm:atSeason \"" + season + "\" . \r\n"
		+ " ?adv arm:inYear " + year + " . \r\n"
		+ " ?adv a arm:CharacterAdvancement . \r\n"
		+ " ?adv ?p ?op . \r\n"
                + "    OPTIONAL { \n"
                + "       ?adv arm:advanceTraitList ?list . \n"
                + "       ?list rdf:rest* ?listRest . \n"
                + "       ?listRest rdf:first ?head ; rdf:rest ?tail . \n"
                + "       ?head ?p1 ?o1 . \n"
                + "    } \n"
                + "}";
       } 

    @GET
    @Path("/{id}/{year}/{season}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAdv(@PathParam("id") String ID,
                                 @PathParam("year") int year,
                                 @PathParam("season") String season ) 
				 throws IOException {
        String frame = Config.getInstance().advancementframe ;
        String result = ArMModel.construct(queryStringSeason(ID,year,season),frame);
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

}

