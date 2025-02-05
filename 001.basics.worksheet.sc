// val deyince değişilmiyor
// var diyerek değişebilirsin
// worksheet dynamic bir envir.
//yazmaya val ile başla gerekirse değiş
val intd = 5
// intd=6 hata
var inta=4
inta=8
val stringd= "hello"; val abc="abc" // type inference. aynı satırdayken ; kullan
val longd= 1L

/* explicit declaration
val {varname} : {type} = {value}

commonly used types:
byte, char, short, int- richInt, long, double- richDouble, float, boolean, string- stringOps
 */

// operator overloading yapabilirsin, +'nın anlamını değişmek etc
val aresult = 2 + 3 * 3 // işlem önceliği var, 11
val aresulte = 2.+(3.*(3)) // a+b shorthand for a.+(b), 11
"istanbul".contains("n")
"istanbul" contains "n"
val hayat="hayat"
hayat.toUpperCase()

class Person(val name: String) {
  def :/:(p:Person) = new Person(name + p.name)
}

val a = new Person("a")
val b= new Person("b")
a :/: b

/* scala is a expression oriented
everything we write is an expression
 */
var vara=5
val ex1 = 2+3 // right side is expres.
val ex2 = vara+=1 // assignment is expre.
// control structures:
val a = 3
val ifResult = if(a % 2 == 0) 5 else 4
var ifvar=true
if (a % 2== 1) ifvar = false else ifvar

try{
  throw new Exception
} catch{
  case e:Exception => println(s"catched expression")
}
// sonradan yazacaksan ??? yaz
def divide(a:Int, b:Int):Int = ???
// hata aldığında (0'a bölünme gibi
def divide(a:Int, b:Int):Either[String,Int] = ???