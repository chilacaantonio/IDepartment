@idr.each { |a|
  @datos.each { |dat|
if @idr[@idr.index(a)] == dat.cual
  pdf.image "app/assets/images/"+@idr[@idr.index(a).to_i]+".png",:scale => 0.5 , :position => :center
  pdf.text @titulo1[@idr.index(a).to_i], :style => :bold , :align => :center , :size => 20
  pdf.text @sub1[@idr.index(a).to_i], :align => :center
  pdf.text "Chair members: "+@quien1[@idr.index(a).to_i], :align => :center
  pdf.text "Level: "+@level1[@idr.index(a).to_i], :align => :center
  pdf.text "Grade: "+@grade1[@idr.index(a).to_i], :align => :center
  pdf.move_down(50)
end

}
}
