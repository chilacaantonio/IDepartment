if current_user.admin!=1
prawn_document() do |pdf|
pdf.text "#{current_user.name} #{current_user.paterno} #{current_user.materno}"
pdf.text "Los comites a los que perteneces son: ", :style => :bold
pdf.move_down(30)

if @opc && @ss=="2"
  render "pdf2", :pdf => pdf
elsif @opc && @ss=="1"
  render "pdf1", :pdf => pdf
end

end

else
  controller.redirect_to "public/404.html"
end
