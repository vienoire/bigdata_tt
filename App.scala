import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{avg, col, count}
// val adına bakarken ampul çıkıyor, type annotation ekleyebilirsin
// unit=void
object App {
  def main(args: Array[String]): Unit = {
    val sparkConf = new SparkConf()
      .setAppName("CountByValue")
      .setMaster("local[*]")
    val spark=SparkSession.builder().config(sparkConf).getOrCreate()
    val moviesFilePath: String = "src/main/resources/movie_lens/movie.csv"
    val ratingsFilePath = "src/main/resources/movie_lens/rating.csv"
    val moviesDF= spark.read
      .option("header", "true")
      .option("inferSchema", "true").csv(moviesFilePath)

    val ratingDF = spark.read
      .option("header", "true")
      .option("inferSchema", "true").csv(ratingsFilePath)

    moviesDF.show(10)
    ratingDF.show(10)

    val ratingByMovieDF = ratingDF.groupBy("movieId").avg("rating")
    ratingByMovieDF.show(10)
    // ,false titleları kesilmeden gösteriyor
    ratingByMovieDF.join(moviesDF, "movieId").orderBy("avg(rating)").show(10, false)
    ratingByMovieDF.join(moviesDF, "movieId").orderBy(col("avg(rating)").desc).show(10, false)
    val ratingByMovieDFAgg = ratingDF.groupBy("movieId")
      .agg(
        avg("rating"),
        count("rating")
      )
    ratingByMovieDFAgg.show(10)
  }

}
