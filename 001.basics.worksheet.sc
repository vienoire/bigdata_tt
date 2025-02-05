// val deyince değişilmiyor
// var diyerek değişebilirsin
// worksheet dynamic bir envir.
//yazmaya val ile başla gerekirse değiş
val intd = 5
// intd=6
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
// çıktıda değiştiğini göstermiyor aşağıdakiyle kontrol ettim
var ab= ifvar
try{
  throw new Exception
} catch{
  case e:Exception => println(s"catched expression")
}
// sonradan yazacaksan ??? yaz
def divide(a:Int, b:Int):Int = ???
// hata aldığında (0'a bölünme gibi) string, int otherwise
def divide(a:Int, b:Int):Either[String,Int] = ???

val x=0
val rangex= x .to(10)
// aşağıdakine myvector= ataması yapabilirsin
for (i<- 1 to  3; j<- 1 to 10)
  println(s"$i.$j")

// methods (not 100%functions)
def abs(x: Double): Double= if(x>=0) x else -x
def absE(x: Double): Double= if(x>=0) x else -x
def absWithParenthesis(x:Double):Double = {
  if(x>=0) x else -x
}

def add(l: Int, r: Int)=l+r
add(10,34)

def absUnit(x:Double):Unit = {
  if(x>=0) x else -x
}

absWithParenthesis(-100)
absUnit(-200) // void, yanıt vermiyor

val nums: Array[Int] = new Array[Int](10) // default all 0
nums(1)= 2
println(nums(1))
val nums2 = Array(1,2,3) // no need for new, with initial values
println(nums2)
// changing array size forbidden
class MyString(arr:Array[Char], start:Int, end:Int) {
  def sbs(x:Int):MyString = new MyString(arr, 0, x)
}

//mutable arrays
import scala.collection.mutable.ArrayBuffer
val arrayBuffer= ArrayBuffer(1,2,3)
arrayBuffer += 4 // (1,2,3,4)
arrayBuffer += 5 // (1,2,3,4,5)
/*for(i<-arrayBuffer)
  println(arrayBuffer(i)) // (2,3,4,5) çünkü i içinde, array dışına çıkıp hata veriyor*/

for(i<-arrayBuffer)
  println(i) // doğrusu bu (1,2,3,4,5)

for(i<-0 until arrayBuffer.length)
  print(arrayBuffer(i))        //print dersen yan yana ln ile alt alta

arrayBuffer(4) = 3
println(arrayBuffer) // (1,2,3,4,3)
println(arrayBuffer(0)) // 1

val nums3= for (i <- arrayBuffer) yield i*3 // (3,6,9,12,9)
val matrix = Array.ofDim[Double](3,4) // x 3, y 4
matrix(2)(2) = 2 // y 3, x 3'e atama yapıyor 2'yi gerisi 0
for(row<- matrix; cell<-row) yield cell * 2 // 2 olan yer 4 oluyor

for{
  row<- matrix
  cell<-row
} yield cell * 3 // 6 oldu, fordakiler matrixi değiştirmiyor

val matrix2 = for{
  row<-matrix
  a = for (cell<- row) yield cell *5
} yield a // 10 yapıyor. üsttekiler 1d array bu 2d matrix

// tuples, immutable 2. değer str değişmez
// ilk elemanı 1, 0 yok
val t2= (1, "str")
val t3 = (1, "str", 1L)
val t4=(1, "str", 1L, 2d)

import scala.beans.BeanProperty
// most basic class
class Counter {
  private var i = 0
  def increment()=i +=1 //methods
  def increment(j: Int)= i+=j
  // ikisi de unit yani bir şey return etmiyor
  def increment(a:Int, b:Int):Int= i+a+b
  def current=i
}

val cInstance = new Counter
cInstance.increment() // void olduğundan ekliyor, current değişiyor, return yok
println(cInstance.current) // 1
cInstance.increment(15) // void olduğundan ekliyor, current değişiyor, return yok
println(cInstance.current) // 16
cInstance.increment(23, 34) // 73 return ediyor 16+23+34
println(cInstance.current) // yine 16. 3.sü return ediyor veriyi değişmiyor

// class constructor parameters
class HelloClass(other: String="universe") {
  //body off constructor
  private val all = "hello " + other
  private val all2 = "hello2 " + other
  def hello: String = all
  def hi: String = all2
}
val h = new HelloClass("world")
val h2 = new HelloClass()
println(h.hello) // hello world
println(h2.hello) // hello universe
println(h) // adres
println(h.hi) // hello2 world
println(h2.hi) // hello2 universe

//sonrası için aynı isimde class ve object üretirsen companion
//  06 objects eksik
// objeleri nasıl karşılaştıracağını biliyor, true
// object bilmiyor so false

// CHANGED DATA CAPTURE/CAPTION

class Person(val anme: String, val age: Int)
val p1 = new Person("anil", 1)
println(p1)

// nested classes nested functions
class Parent(val o: Int) {
  def age: Int = o // ben ekledim burayı
  class Member(i: Int) {
    def sum: Int = o - i
  }
}
val parent1 = new Parent(35)
val child1 = new parent1.Member(20)
println(parent1.age) // 35
println(child1.sum) // 15
// hata veriyor println(child1.age)
// hata veriyor println(parent1.sum)



// COLLECTIONS
import java.util
import scala.collection.mutable.ArrayBuffer

// linked listtir scalada -- öne eklemek hızlı, son yavaş
val list = List(1,2,3)   // (1, 2, 3)
val list2 = list.appended(4) // (1, 2, 3, 4)
val list3=0:: list2 // (0, 1, 2, 3, 4)
val emptyList=List.empty[Int]  // ()
val emptyList2 : List[Int] = Nil // ()
val startWithEmpty= 1::2:: Nil // (1, 2)
val check1= 1::2::5::6:: Nil // (1, 2, 5, 6)
// val check2= 1::2 hata veriyor linked list olduğundan
list.head // başını verir /println demen lazım return için / 1
println(list.headOption) // aynısı / Some(1)
// emptyList.head boş olduğu için hata veriyor
emptyList.headOption // boş olsa da hata vermiyor return: None
list.take(2) // (1, 2), sizedan büyük yazarsan hata vermiyor, olduğu kadar yazıyor
list.reverse // (3, 2, 1)
val list4= List(5,8,6)
val mapped = list.map(i=>i*2) // map A=>B  (2, 4, 6)
val mapped = list.map(i=> "+" + i.toString + "+") // (+1+, +2+, +3+)
val filtered = list.filter(i=>i%2==0) // (2)
val flattenList = list.map(i=>List(i,i)).flatten // (1, 1, 2, 2, 3, 3)
val flatMapList= list.flatMap(i=> List(i,i,i)) //(1, 1, 1, 2, 2, 2, 3, 3, 3)
// + - falan yazabilirsin, sol veya sağdan başlıyor + - * /
val reduced = list.reduce(_ * _)  // 6 -4 6 0
val reduced = list.reduceLeft(_ + _) // 6 -4 6 0
val folded = List.empty[Int].foldLeft(5)(_ - _) // 5
// EN SOLDAN/SAĞDAN ELEMANA GÖRE YAPIYOR en sol- (x)
val folded =list.foldLeft(20)(_ - _) // 14
val fold3 = list4.foldRight(15)(_ - _) //-12 /  6-15=-9, 8--9=17, 5-17=-12
val fold2 =list4.foldLeft(10)(_ - _) // -9 / 10-5=5-8=-3-6=-9


// flat map ve flatten aynı şey
