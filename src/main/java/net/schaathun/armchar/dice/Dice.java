/* (C) 2017: Hans Georg Schaathun <georg@schaathun.net> */

package net.schaathun.armchar.dice;

import java.io.OutputStream;
import java.io.IOException;
import java.io.ByteArrayInputStream;
import javax.ws.rs.core.Response;
import java.io.ByteArrayInputStream;

import java.util.List ;

import net.schaathun.armchar.util.Writer ;

public class Dice {
   private static Dice instance = null;

   private Dice() {

   }

   public static Dice getInstance() {
      if(instance == null) {
         instance = new Dice();
      }
      return instance;
   }

}
