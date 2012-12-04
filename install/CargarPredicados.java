import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.FieldPosition;

import conf.VariablesAmbiente;

import Cliente.ClienteSQLfi;
import Cliente.ClienteSQLfiImpl;
import Despachador.ConjuntoResultado;
import Despachador.Mu;
import Despachador.ObjetoSQLfi;



public class CargarPredicados{
	
	
	public static void main(String [] args) throws SQLException, Exception{
		    
		// Se leen los parametros y se da la conexion
		ClienteSQLfi app = new ClienteSQLfiImpl();
		app.cargarConfiguracion();
		app.conectarUsuarios();

		
		
		String [] predicados = {
          
          " CREATE FUZZY PREDICATE calidad_prof_bajo ON 1..5 AS (1, 1, 1.3, 2.6) ; ", 
			 " CREATE FUZZY PREDICATE calidad_prof_medio ON 1..5 AS (2.5, 3, 3.5, 4) ; ", 
			 " CREATE FUZZY PREDICATE calidad_prof_alto ON 1..5 AS (4, 4.4, 5, 5) ; ", 
			 " CREATE FUZZY PREDICATE esfuerzo_bajo ON 1..5 AS (1, 1, 1, 2) ; ", 
			 " CREATE FUZZY PREDICATE esfuerzo_medio ON 1..5 AS (2, 2.5, 3, 3.2) ; ", 
			 " CREATE FUZZY PREDICATE esfuerzo_alto ON 1..5 AS (3.5, 4.2, 5, 5) ; ", 
			 " CREATE FUZZY PREDICATE utilidad_bajo ON 1..5 AS (1, 1, 1.5, 2) ; ", 
			 " CREATE FUZZY PREDICATE utilidad_medio ON 1..5 AS (2, 2.5, 3, 3.5) ; ", 
			 " CREATE FUZZY PREDICATE utilidad_alto ON 1..5 AS (3.5, 4.2, 5, 5) ; ", 
			 " CREATE FUZZY PREDICATE dificultad_bajo ON 1..5 AS (1, 1, 1, 2.5) ; ", 
			 " CREATE FUZZY PREDICATE dificultad_medio ON 1..5 AS (2.5, 3, 3.5, 4) ; ", 
			 " CREATE FUZZY PREDICATE dificultad_alto ON 1..5 AS (4, 5, 5, 5) ; ", 
			 " CREATE FUZZY PREDICATE preparacion_bajo ON 1..5 AS (1, 1, 1.3, 1.8) ; ", 
          " CREATE FUZZY PREDICATE preparacion_medio ON 1..5 AS (1.8, 2.3, 2.8, 3.2) ; ",
          " CREATE FUZZY PREDICATE preparacion_alto ON 1..5 AS (3.2, 4.4, 5, 5) ; ",
          " CREATE FUZZY PREDICATE expectativa_bajo ON 1..5 AS (1, 1, 1, 2.9) ; ",
          " CREATE FUZZY PREDICATE expectativa_medio ON 1..5 AS (2.9, 3, 3.5, 4) ; ",
          " CREATE FUZZY PREDICATE expectativa_alto ON 1..5 AS (4, 4.6, 5, 5) ; "
      };

      for(int i=0;i<predicados.length;i++){
		
          ObjetoSQLfi obj = app.ejecutarSentencia(predicados[i]);
          
      }
      
      app.desconectarUsuarios();
   }
	
    
	
	
}
