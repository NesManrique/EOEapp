package controllers;

import play.mvc.*;

import views.html.*;

public class Application extends Controller {
  
  public static Result index() {
	  	return ok(index.render());
  }
  
  public static Result consulta(){
	  
	  return ok(questions.render());
  }
  
  public static Result resconsulta(){
	  
	  return TODO;
  }
  
  public static Result config(){
	  	return ok(config.render());
  }
  
  public static Result updatePredicate(){
		return TODO;
  }
  
}