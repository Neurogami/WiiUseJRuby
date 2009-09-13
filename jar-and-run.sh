# Assumes you have a Jimpanzee app with Roir.  And this script might only be needed on Linux.
# It's here pending better resolution of loading binary libs from a JRuby app.  
# The Wii java code needs a .so file.

jruby -S rake roir:jar
LD_LIBRARY_PATH=./lib/java/ java -Djava.library.path=./lib/java/  -jar package/jar/NAME-OF-YOUR-APP.jar  

