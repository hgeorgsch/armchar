/* (C) 2020: Hans Georg Schaathun <georg@schaathun.net> */

package net.schaathun.armchar.dice;

import java.io.OutputStream;
import java.io.IOException;
import java.io.ByteArrayInputStream;
import javax.ws.rs.core.Response;
import java.io.ByteArrayInputStream;
import java.util.Random ;

import java.util.List ;

import net.schaathun.armchar.dice.Dice ;
import net.schaathun.armchar.util.Writer ;

public class DieRoll {

   private int nbotchdice = 0, nbotch = 0, nones = 0, last = 0, result = 0 ;

   private DieRoll( ) {
      int roll = Dice.simpledie() ;
      if ( roll == 1 ) {
	 while ( roll == 1 ) {
	    ++this.nones ;
	    roll = Dice.simpledie() ;
	 }
	 this.last = roll ;
	 this.result = roll*(1<<this.nones) ;
      } else {
	 this.last = roll ;
	 this.result = roll ;
      }
   }
   private DieRoll( int nb ) {
      this.nbotchdice = nb ;
      int roll = Dice.simpledie() ;
      if ( roll == 10 ) {
	 this.last = 0 ;
	 this.result = 0 ;
	 for ( int i=0 ; i<nb ; ++i ) {
             roll = Dice.simpledie() ;
	     if ( roll == 10 ) ++this.nbotch ;
	 }
      } else if ( roll == 1 ) {
	 while ( roll == 1 ) {
	    ++this.nones ;
	    roll = Dice.simpledie() ;
	 }
	 this.last = roll ;
	 this.result = roll*(1<<this.nones) ;
      } else {
	 this.last = roll ;
	 this.result = roll ;
      }
   }

}
