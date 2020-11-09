/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.schaathun.armchar.util;

import java.io.ByteArrayInputStream;
import java.io.OutputStream;
import javax.ws.rs.core.Response;
import org.apache.jena.query.Dataset;
import org.apache.jena.query.ReadWrite;
import org.apache.jena.rdf.model.InfModel;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.riot.RDFFormat;
import org.apache.jena.riot.WriterDatasetRIOT;
import org.apache.jena.riot.system.PrefixMap;
import org.apache.jena.riot.system.RiotLib;
// import org.apache.jena.shared.uuid.JenaUUID;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.sparql.util.Context;
import org.apache.jena.tdb.TDBFactory;
import org.apache.jena.util.FileManager;

import org.apache.jena.reasoner.Reasoner;
import org.apache.jena.reasoner.ReasonerRegistry ;

/**
 *
 * @author quetran
 */
public class Writer {

    public static void write(OutputStream out, DatasetGraph g, RDFFormat f, Context ctx) {
        // create a WriterDatasetRIOT with the RDFFormat
	System.out.println( "Writer write" ) ;
	if ( g == null ) System.out.println( "g is null" ) ;
	if ( f == null ) System.out.println( "f is null" ) ;
	if ( ctx == null ) System.out.println( "ctx is null" ) ;
	if ( out == null ) System.out.println( "out is null" ) ;
        WriterDatasetRIOT w = RDFDataMgr.createDatasetWriter(f);
	if ( w == null ) System.out.println( "w is null" ) ;
        PrefixMap pm = RiotLib.prefixMap(g);
	if ( pm == null ) System.out.println( "pm is null" ) ;
        String base = null;
        w.write(out, g, pm, base, ctx);
    }
}
