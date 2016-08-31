@imagen.each { |a|
  @datos.each { |dat|
if @imagen[@imagen.index(a)] == dat.cual
  pdf.image "app/assets/images/"+@imagen[@imagen.index(a).to_i]+".png",:scale => 0.5 , :position => :center
  pdf.text @titulo[@idr.index(a).to_i], :style => :bold , :align => :center , :size => 20
  pdf.text @sub[@idr.index(a).to_i], :align => :center
  pdf.text "Chair members: "+@quien[@imagen.index(a).to_i], :align => :center
  pdf.text "Level: "+@level[@imagen.index(a).to_i], :align => :center
  pdf.text "Grade: "+@grade[@imagen.index(a).to_i], :align => :center
  pdf.move_down(50)
end

}
}
