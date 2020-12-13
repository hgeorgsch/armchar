package net.schaathun.armchar ;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;


public class Config {

    // public static final String location = "/var/onsite/tdb";

   private static String charsheetframefile = "/opt/payara/serverdata/charsheet.frame" ;
   private static String advancementframefile = "/opt/payara/serverdata/advancement.frame" ;
   public final String charsheetframe ;
   public final String advancementframe ;
   private static Config instance = null ;

   private Config() throws IOException {

      this.charsheetframe = 
              new String(Files.readAllBytes(Paths.get(charsheetframefile)));
      this.advancementframe = 
              new String(Files.readAllBytes(Paths.get(advancementframefile)));



   }
   public static Config getInstance() throws IOException {
      if(instance == null) {
         instance = new Config();
      }
      return instance;
   }

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
