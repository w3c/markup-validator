d=document
w=window
msgs=new Array()
if (w && d && d.getElementsByTagName){
 w.onload=doubleUp
}
function doubleUp() {
 glist=d.getElementsByTagName("DIV")
 upto(1)
}
function upto(n) {
 if (n<glist.length) {
  for (i=n;i<glist.length && i<n+10;i++) {
   j=glist[i]
   cls=j.className
   if (cls) cls=cls.split(' ')
   if (cls.length>1) {
    if (cls[0]=='ve') msgs[cls[1]]=j.innerHTML
    if (cls[0]=='hidden' && msgs[cls[1]]) {
     j.className="ve "+cls[1]
     j.innerHTML=msgs[cls[1]]
    }
   }
  }
  if (w && w.setTimeout) setTimeout('upto('+i+')',500)
 }
}
