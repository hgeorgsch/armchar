package net.schaathun.armchar.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

/**
 *
 * @author 
 */
@Path("test")
public class Test {
    
    @GET
    public Response ping(){
        return Response
                .ok("ping")
                .build();
    }
}
