# Se agrega un nuevo usuario para usar como prueba en la autenticacion
user = User.new
user.email = 'jgaviri6@eafit.edu.co'
user.password = '123456'
user.password_confirmation = '123456'
user.save!
