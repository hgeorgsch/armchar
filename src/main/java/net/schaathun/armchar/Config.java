package net.schaathun.armchar ;

public class Config {

    // public static final String location = "/var/onsite/tdb";

    public static String prefix = 
              "prefix owl: <http://www.w3.org/2002/07/owl#>\r\n"
            + "prefix xsd:   <http://www.w3.org/2001/XMLSchema#>\r\n" 
            + "prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\r\n"
            + "prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>\r\n"
            + "prefix foaf: <http://xmlns.com/foaf/0.1/>\r\n" 
            + "prefix arm: <https://hg.schaathun.net/armchar/schema#>\r\n" 
            + "prefix armchar: <https://hg.schaathun.net/armchar/character/>\r\n" ;

    public static String prefixJS_LD = 
              "\"owl\" : \"http://www.w3.org/2002/07/owl#\",\n"
            + "\"xsd\" : \"http://www.w3.org/2001/XMLSchema#\",\n"
            + "\"rdf\" : \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\",\n"
            + "\"rdfs\" : \"http://www.w3.org/2000/01/rdf-schema#\",\n"
            + "\"foaf\" : \"http://xmlns.com/foaf/0.1/\",\n"
            + "\"arm\" : \"https://hg.schaathun.net/armchar/schema#\"," 
            + "\"armr\" : \"https://hg.schaathun.net/armchar/resources#\"," 
            + "\"armab\" : \"https://hg.schaathun.net/armchar/resources/abilities#\"," 
            + "\"armchar\" : \"https://hg.schaathun.net/armchar/character/\"" ;
}
