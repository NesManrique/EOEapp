import sbt._
import Keys._
import PlayProject._

object ApplicationBuild extends Build {

<<<<<<< HEAD
    val appName         = "playapp"
=======
    val appName         = "EOEapp"
>>>>>>> 87e52c0f3ace41d80b09dcbf339d70bfbd9de347
    val appVersion      = "1.0-SNAPSHOT"

    val appDependencies = Seq(
      // Add your project dependencies here,
    )

    val main = PlayProject(appName, appVersion, appDependencies, mainLang = JAVA).settings(
      // Add your own project settings here      
    )

}
