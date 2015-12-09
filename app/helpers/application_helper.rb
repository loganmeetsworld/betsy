module ApplicationHelper
  def render_stars(rating)
    output = ''
    if (1..5).include?(rating)
      rating.times { output += image_tag('star.png') }
    end
    output.html_safe
  end
end
