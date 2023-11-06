# Expression for identical elements.
# Har definert og lagt alle flagg-elementene oppå hverandre ved hjelp av "overlay-xy"
fun flag-display(vertical-cross-color,horizontal-cross-color, bottom-vertical-cross-color, bottom-horizontal-cross-color,base-color):
frame(
    overlay-xy(rectangle(16, 128,"solid", vertical-cross-color),-65, -0, 
      overlay-xy(rectangle(200,16, "solid", horizontal-cross-color),0, -57,
        overlay-xy(rectangle(30, 128, "solid", bottom-vertical-cross-color), -58, 0,
          overlay-xy(rectangle(200, 30, "solid", bottom-horizontal-cross-color),0, -50,
            rectangle(200,128, "solid", base-color))))))
end

# Her er alle flaggene som har blitt laget, Danmark, Sverige, Norge, Island, og Finland i rekkefølge.

# Danmark
flag-display("white", "white", "white", "white", "red")

# Sverige
flag-display("yellow", "yellow", "yellow", "yellow","royal blue")

# Norge
flag-display("blue","blue","white", "white", "red")

# Island
flag-display("red", "red", "white", "white", "royal blue")

# Finland
flag-display("blue", "blue", "blue", "blue", "white")

# Funksjon for brukeren å kunne taste inn hvilket flagg de vil vise ved bruk av "Vis(flagg)", og bruker "if", "else if", og "else". 

fun Vis(flagg):
 
  if flagg == "Danmark": flag-display("white", "white", "white", "white", "red")
  else if flagg == "Sverige": flag-display("yellow", "yellow", "yellow", "yellow","royal blue")
  else if flagg == "Norge": flag-display("blue","blue","white", "white", "red")
  else if flagg == "Island": flag-display("red", "red", "white", "white", "royal blue")
  else if flagg == "Finland": flag-display("blue", "blue", "blue", "blue", "white")
  else:"Error"
    end
  end