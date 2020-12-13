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

@Path("/Character")
public class Character {

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacter(@PathParam("id") String ID) {

        String queryString = Config.prefix
                + "CONSTRUCT {"
		+ "    armchar:" + ID + " ?p1 ?o1 . "
		+ "    armchar:" + ID + " arm:hasAdvancementList ?advlist . "
		+ "    ?advlist  arm:hasTraitList ?tl . "
		+ "    ?o1 ?p2 ?o2 .  \r\n"
		+ "    ?o2 ?p3 ?o3 .  \r\n"
		+ "    ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . "
		+ "    ?listRest rdf:first ?head ; rdf:rest ?tail . "
                + "} WHERE {"
		+ "    armchar:" + ID + " ?p1 ?o1 .\r\n" 
		+ "    NOT EXISTS { ?p1 rdf:type arm:ignoredProperty }  \r\n"
                + "  OPTIONAL { ?o1 ?p2 ?o2 .\r\n"
		+ "     NOT EXISTS { ?p2 a arm:ignoredProperty }  \r\n"
		+ "     NOT EXISTS { ?o1 a owl:Class }  \r\n"
                + "     OPTIONAL { ?o2 ?p3 ?o3 .\r\n"
		+ "        NOT EXISTS { ?p3 a arm:ignoredProperty }  \r\n"
		+ "        NOT EXISTS { ?o2 a owl:Class }  \r\n"
                + "} } \r\n"
       + "OPTIONAL { \n"
       + "  armchar:" + ID + " arm:hasAdvancementList ?advlist . "
       + "  ?advlist rdf:rest* ?advlistRest . \n"
       + "  ?advlistRest rdf:first ?advhead ; rdf:rest ?advtail . \n"
       + "  OPTIONAL { \n"
       + "     ?adv  arm:hasTraitList ?list . \n"
       + "     ?list rdf:rest* ?listRest . \n"
       + "     ?listRest rdf:first ?head ; rdf:rest ?tail . \n"
       + "  } \n"
       + "} \n"
                + "}";
        String result = ArMModel.construct(queryString);
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

    private String queryString(String id, int year, String season) {
       return this.queryString(
                " ?sheet arm:isCharacter armchar:" + id + " . \r\n"
		+ " ?sheet arm:atSeason \"" + season + "\" . \r\n"
		+ " ?sheet arm:inYear " + year + " . \r\n"
	     ) ;
    }

    private String queryString(String id, String season) {
       return this.queryString(
                " ?sheet arm:isCharacter armchar:" + id + " . \r\n"
		+ " ?sheet arm:atSeasonTime arm:" + season + " . \r\n"
	     ) ;
    }

    private String queryString(String w) {
       return Config.prefix
                + "CONSTRUCT { \r\n" 
		+ " ?sheet a arm:CharacterSheet . \r\n"
		+ " ?sheet ?dp ?dval .  \r\n"
		+ " ?sheet ?op ?oval . \r\n"
                + " ?oval ?obp ?obval . \r\n" 
                + " ?oval a ?type . \r\n" 
		+ " ?sheet ?op ?oval . \r\n"
                + "} WHERE { \r\n " 
		+ w
		+ " ?sheet a arm:CharacterSheet . \r\n"
		+ " ?sheet ?dp ?dval . \r\n"
		+ " ?sheet ?op ?oval . \r\n"
		+ " NOT EXISTS { ?oval a arm:CharacterSheet }\r\n"
		+ " NOT EXISTS { ?op a arm:ignoredProperty }\r\n"
		+ " ?dp a owl:DatatypeProperty . \r\n"
		+ " ?op a owl:ObjectProperty . \r\n"
                + " ?oval ?obp ?obval . \r\n" 
                + " ?oval a ?type . \r\n" 
		+ " ?obp a owl:DatatypeProperty . \r\n"
                + "}";
       } 
    @GET
    @Path("/{id}/{season}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacterSheet2(@PathParam("id") String id,
                                 @PathParam("season") String season ) 
				 throws IOException {

        String frame = Config.getInstance().charsheetframe ;
        String result = ArMModel.construct(this.queryString(id,season),frame);
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }
    @GET
    @Path("/{id}/{year}/{season}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCharacterSheet(@PathParam("id") String id,
                                 @PathParam("year") int year,
                                 @PathParam("season") String season ) 
				 throws IOException {

        String frame = Config.getInstance().charsheetframe ;
	String q = this.queryString(id,year,season) ;
        // System.out.println( "getCharacterSheet " + season + year ) ;
        // System.out.println( q ) ;
        String result = ArMModel.construct(q,frame);
        // System.out.println( result ) ;
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

    @GET
    @Path("/unframed/{id}/{season}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUnframedCharacter(@PathParam("id") String id,
                                 @PathParam("season") String season ) 
				 throws IOException {

        String frame = Config.getInstance().charsheetframe ;
        String result = ArMModel.construct(this.queryString(id,season));
	if ( result == null ) {
           return Response.status(404).build();
	}
        return Response
                .ok(result)
                .build();
    }

}

