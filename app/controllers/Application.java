package controllers;

import play.*;
import play.mvc.*;
import java.util.Map;
import views.html.*;
import java.lang.String;
import java.sql.*;
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

public class Application extends Controller {
  
    public static String EjecutarConsulta(String consulta){

        
        ClienteSQLfi app = new ClienteSQLfiImpl();

        try{
            app.cargarConfiguracion();
            app.conectarUsuarios();
        }
        
        catch (Exception e){

            e.printStackTrace();
            return ("<h1>Error</h1><p>No se pudo establecer conexión con el repositorio de datos, "+
                    "por favor intente más tarde, en caso de que el problema persista, "+
                    "comuniquese con nuestro administrador mediante el correo wm@consulta.dii.usb.ve</p>");
        }


        ObjetoSQLfi obj ;

        try{
            obj = app.ejecutarSentencia(consulta);
        }
        catch (Exception e){
        
            e.printStackTrace();
            return ("<h1>Error</h1><p>No se pudo procesar su pregunta de manera exitosa, "+
                    "por favor intente más tarde, en caso de que el problema persista, "+
                    "comuniquese con nuestro administrador mediante el correo wm@consulta.dii.usb.ve</p>");
        }   
        
        StringBuffer resultado= ConjuntoRes(obj);
        
        return (resultado.toString());
        
    }



    public static boolean verificarPredicado(String predicado){
        
        try {
            
            Class.forName("org.postgresql.Driver");
            
        }
        catch (ClassNotFoundException e) {
 
            System.out.println("Error, No se pudo conseguir el driver de postgres");
            e.printStackTrace();
            return false;
 
        }
        
         
        Connection connection = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            
            connection = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/sqlfi_leonid", "sqlfi","sqlfi");
 
        }catch (SQLException e) {
 
            System.out.println("No se puedo establecer conexion con la base de datos");
            e.printStackTrace();
            return false;
            
        }
        

        int existe;
        
        try{
            CallableStatement verificarP = connection.prepareCall("{ ? = call existe_predicado( ? ) }");
            verificarP.registerOutParameter(1, Types.INTEGER);
            verificarP.setString(2,predicado);
            verificarP.execute();
            existe = verificarP.getInt(1);
            connection.close();
        
        }
        catch(SQLException e){

            System.out.println("Hola soy bata");
            e.printStackTrace();
            return false;
            
        }

        if (existe == 0){
            return false;
        }
        else{
            return true;
        }
        
    }

    public static StringBuffer ConjuntoRes(ObjetoSQLfi obj){
	
        StringBuffer resultado = new StringBuffer();
      
        DecimalFormatSymbols dfs = new DecimalFormatSymbols();
        dfs.setDecimalSeparator('.');
        DecimalFormat df = new DecimalFormat(VariablesAmbiente.FUZZY_MU_DECIMAL_FORMAT,dfs);
        
        int numCols = ((ConjuntoResultado) obj).obtenerMetaDatos().obtenerNumeroColumnas();
        ((ConjuntoResultado) obj).primero();
        
        resultado.append("<table>");
        
        // Se imprime el encabezado

        resultado.append("<thead><tr>");
        for (int cont = 2; cont <= numCols; cont++) {
            resultado.append("<th>");
            resultado.append(((ConjuntoResultado) obj).obtenerMetaDatos().obtenerEtiquetaColumna(cont).replace('_',' '));
            resultado.append("</th>");
        }

        resultado.append("<th>");
        resultado.append("puntuacion");
        resultado.append("</th>");
        
        resultado.append("</tr></thead>");
        

        Object objetoResultado;
        ((ConjuntoResultado) obj).antesDelPrimero();
        // Se imprimen las filas
        while (((ConjuntoResultado) obj).proximo()) {
            resultado.append("<tr>");
            for (int cont = 2; cont <= numCols; cont++) {
                resultado.append("<td>");
                objetoResultado = ((ConjuntoResultado) obj).obtenerObjeto(cont);
                resultado.append(objetoResultado);
                resultado.append("</td>");
            }
            resultado.append("<td>");
            objetoResultado = ((ConjuntoResultado) obj).obtenerObjeto(1);
            resultado.append(df.format(((Mu) objetoResultado).obtenerValorMu(),new StringBuffer(""),new FieldPosition(0)));
            resultado.append("</td>");
            resultado.append("</tr>");
            
	            
        }

        resultado.append("</table>");
        return resultado;
    }


    public static Result index() {
        return ok(index.render());
    }
  
    public static Result consultaC(){
	  
        return ok(questions.render());
    }
  
    public static Result consultaS(){
	  
        return ok(questions2.render());
    }
    
    public static Result preguntaUnoS(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        
        // ASUMO QUE ME PASARAN EL SESSION MEDIANTE UN STRING ASI
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado= sesion+"_"+values.get("p1")[0];
        String consulta;
        
        
        // SI EXISTE UN PREDICADO PERSONALIZADO EN LA BD USARLO

        if(verificarPredicado(predicado)){
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vmat_dificultad  " +
                "WHERE promedio = " + predicado +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
            
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vmat_dificultad  " +
                "WHERE promedio = " + values.get("p1")[0] +" ;";
            
        }
        
        
        
        String respuesta=EjecutarConsulta(consulta);
        return ok(respuestas.render(respuesta));
    }

    public static Result preguntaDosS(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
 
        // ASUMO QUE ME PASARAN EL SESSION MEDIANTE UN STRING ASI
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado= sesion+"_"+values.get("p2")[0];
        String consulta;
        
        		
        if(verificarPredicado(predicado)){
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vmat_esfuerzo  " +
                "WHERE promedio = " + predicado +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
            
            consulta = "SELECT cod_materia, nombre_materia " +
            "FROM vmat_esfuerzo  " +
            "WHERE promedio = " + values.get("p2")[0] +" ;";
        
        }
        
        String respuesta=EjecutarConsulta(consulta);
        
        
        return ok(respuestas.render(respuesta));
    }

    public static Result preguntaTresS(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
 
        
        // ASUMO QUE ME PASARAN EL SESSION MEDIANTE UN STRING ASI
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado= sesion+"_"+values.get("p3")[0];
        String consulta;
        
        		
        if(verificarPredicado(predicado)){
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vmat_utilidad  " +
                "WHERE promedio = " + predicado +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
        
            consulta = "SELECT cod_materia, nombre_materia " +
                "FROM vmat_utilidad  " +
                "WHERE promedio = " + values.get("p3")[0] +" ;";
        }        

        String respuesta=EjecutarConsulta(consulta);
        
        
        return ok(respuestas.render(respuesta));
    }

    public static Result preguntaCuatroS(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        
        		
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado= sesion+"_"+values.get("p4")[0];
        String consulta;
        
        		
        if(verificarPredicado(predicado)){
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vprof_calidad  " +
                "WHERE promedio = " + predicado +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
            
            consulta = "SELECT nombre_profesor " +
            "FROM vprof_calidad  " +
            "WHERE promedio = " + values.get("p4")[0] +" ;";
        
        }
        String respuesta=EjecutarConsulta(consulta);
        
        
        return ok(respuestas.render(respuesta));
    }

    public static Result preguntaCincoS(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado= sesion+"_"+values.get("p5")[0];
        String consulta;
        
        		
        if(verificarPredicado(predicado)){
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vmat_expectativa  " +
                "WHERE promedio = " + predicado +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
        
            consulta = "SELECT cod_materia, nombre_materia " +
                "FROM vmat_expectativa  " +
                "WHERE promedio = " + values.get("p5")[0] +" ;";
            
        }
        
        String respuesta=EjecutarConsulta(consulta);
                
        return ok(respuestas.render(respuesta));
    }
    
    public static Result preguntaSeisS(){
	  
     
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado= sesion+"_"+values.get("p6")[0];
        String consulta;
        
        		
        if(verificarPredicado(predicado)){
            consulta="SELECT cod_materia, nombre_materia " +
                "FROM vmat_preparacion  " +
                "WHERE promedio = " + predicado +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
        
            consulta = "SELECT cod_materia, nombre_materia " +
                "FROM vmat_preparacion  " +
                "WHERE promedio = " + values.get("p6")[0] +" ;";
        
        }
        
        String respuesta=EjecutarConsulta(consulta);
        
        return ok(respuestas.render(respuesta));
 
    }

    public static Result preguntaUnoC(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
 
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado1= sesion+"_"+values.get("p1parte1")[0];
        String predicado2= sesion+"_"+values.get("p1parte2")[0];
        String consulta;		

        
        if(verificarPredicado(predicado1) && verificarPredicado(predicado2)){
            consulta="SELECT p.nombre_profesor, pa.codigo, d.nombre_materia " +
            "FROM profesor_asignatura pa, vprof_calidad p , vmat_dificultad d " +
            "WHERE pa.prof_cedula = p.ci_profesor and " + 
            "pa.codigo = d.cod_materia and " + 
            "p.promedio = " + predicado2 + " and d.promedio = " + predicado1 +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
        
            consulta = "SELECT p.nombre_profesor, pa.codigo, d.nombre_materia " +
                "FROM profesor_asignatura pa, vprof_calidad p , vmat_dificultad d " +
                "WHERE pa.prof_cedula = p.ci_profesor and " + 
                "pa.codigo = d.cod_materia and " + 
                "p.promedio = " + values.get("p1parte2")[0] + " and d.promedio = " + values.get("p1parte1")[0] +" ;";
        }
        
        String respuesta=EjecutarConsulta(consulta);
        
        
        return ok(respuestas.render(respuesta));
    }

    public static Result preguntaDosC(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
 
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado1= sesion+"_"+values.get("p2parte1")[0];
        String predicado2= sesion+"_"+values.get("p2parte2")[0];
        String consulta;		

        
        if(verificarPredicado(predicado1) && verificarPredicado(predicado2)){
            consulta="SELECT e.cod_materia, e.nombre_materia " + 
                "FROM vmat_esfuerzo e, vmat_utilidad u " +
                "WHERE e.cod_materia = u.cod_materia and " +
                "e.promedio = " + predicado2 + " and u.promedio = " + predicado1 +" ;";
        }
        // DE LO CONTRARIO USAR LOS DEFAULTS QUE NO TIENEN UN PREFIJO CON EL ID DE UN USUARIO
        else{
        
            consulta = "SELECT e.cod_materia, e.nombre_materia " + 
                "FROM vmat_esfuerzo e, vmat_utilidad u " +
                "WHERE e.cod_materia = u.cod_materia and " +
                "e.promedio = " + values.get("p2parte2")[0] + " and u.promedio = " + values.get("p2parte1")[0] +" ;";
        
            
        }
        String respuesta=EjecutarConsulta(consulta);
        
        return ok(respuestas.render(respuesta));
    }

    public static Result preguntaTresC(){
	  
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
 
        String sesion="0741051";

        // LOS PREDICADOS PERSONALIZADOS SON DE LA FORMA id_predicado, EJ: 0741051_dificultad_alto
        String predicado1= sesion+"_"+values.get("p3parte1")[0];
        String predicado2= sesion+"_"+values.get("p3parte2")[0];
        String consulta;		

        
        if(verificarPredicado(predicado1) && verificarPredicado(predicado2)){
            consulta="SELECT p.nombre_profesor, pa.codigo, u.nombre_materia " +
                "FROM profesor_asignatura pa, vprof_calidad p , vmat_utilidad u " +
                "WHERE pa.prof_cedula = p.ci_profesor and " + 
                "pa.codigo = u.cod_materia and " + 
                "p.promedio = " + predicado2 + " and u.promedio = " + predicado1 + " ;";
        }
        //PROFESOR VS UTILIDAD
        else{
            consulta = "SELECT p.nombre_profesor, pa.codigo, u.nombre_materia " +
                "FROM profesor_asignatura pa, vprof_calidad p , vmat_utilidad u " +
                "WHERE pa.prof_cedula = p.ci_profesor and " + 
                "pa.codigo = u.cod_materia and " + 
                "p.promedio = " + values.get("p3parte2")[0] + " and u.promedio = " + values.get("p3parte1")[0] + " ;";
        
        }
        String respuesta=EjecutarConsulta(consulta);
        
        return ok(respuestas.render(respuesta));
    }
  

    // SI SEGUIMOS EL ESQUEMA DEL RESTO DE LA APLICACION, DEBERIAN HABER 3 FUNCIONES MUY PARECIDAS A ESTA, UNA PARA ALTO, OTRA PARA MEDIO Y OTRA PARA BAJO;
    // OTRA MANERA ES QUE LOS 3 PREDICADOS SE ACTUALICEN A LA VEZ, EN ESE CASO DEBERIAS TENER 3 ARREGLOS DE PREDICADOS Y 3 CICLOS; CUALQUIERA QUE HAGAS ESTA BIEN MIENTRAS FUNCIONE
    public static Result config(){

        final Map<String, String[]> values = request().body().asFormUrlEncoded();
 
        String sesion="0741051";
        
        String predicados []= { sesion+"_dificultad_alto",
                                sesion+"_calidad_prof_alto",
                                sesion+"_utilidad_alto",
                                sesion+"_esfuerzo_alto",
                                sesion+"_preparacion_alto",
                                sesion+"_expectativa_alto"};
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        // LUEGO.... FOR I IN EL ARREGLO DE ARRIBA                                                //
        //     DROP PREDICATE predicados[i];                                                      //
        //     CREATE FUZZY PREDICATE predicados[i] ON 1 .. 5 AS (values.get("ID DEL FORM 0")[0], //
        //                                                        values.get("ID DEL FORM 1")[0], //
        //                                                        values.get("ID DEL FORM 2")[0], //
        //                                                        values.get("ID DEL FORM 3")[0], //
        //                                                        )                               //
        // FIN DEL FOR                                                                            //
        ////////////////////////////////////////////////////////////////////////////////////////////
                                                           
        
        return ok(config.render());
        //return ok(respuestas.render("<p>Su configuración ha sido procesada</p>"));
                
    }
  
    public static Result updatePredicate(){
        return TODO;
    }
  
}
