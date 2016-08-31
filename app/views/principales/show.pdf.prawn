if current_user.admin
prawn_document() do |pdf|
pdf.text "Los comites a los que pertenece", :style => :bold
pdf.text "#{@user.name} #{@user.paterno} #{@user.materno} son:"
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
