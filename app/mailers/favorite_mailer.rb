class FavoriteMailer < ApplicationMailer
  default from: "tpham045@hotmail.com"
  def new_comment(user, post, comment)

     headers["Message-ID"] = "<comments/#{comment.id}@gentle-stream-45974.com>"
     headers["In-Reply-To"] = "<post/#{post.id}@gentle-stream-45974.com>"
     headers["References"] = "<post/#{post.id}@gentle-stream-45974.com>"
 
     @user = user
     @post = post
     @comment = comment

     mail(to: user.email, subject: "From Thuy: testing my app sending email. New comment on #{post.title}")
     
  end
end
