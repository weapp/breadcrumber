module BreadcrumberHelper
  def breadcrumber
    if @breadcrumbs
      content_tag(:ol, class: :breadcrumb) do
        @breadcrumbs[0..-2].collect do |txt, path|
          content_tag(:li, {:itemscope => "", :itemtype => "http://data-vocabulary.org/Breadcrumb"}) do
            link_to(path, :itemprop => "url") do
              content_tag(:span, {:itemprop => "title"}) do
                txt
              end
            end
          end
        end.join.html_safe +
        content_tag(:li, {:itemscope => "", :itemtype => "http://data-vocabulary.org/Breadcrumb"}) do
          link_to(@breadcrumbs.last.last, class: :current, :itemprop => "url") do
            content_tag(:span, {:itemprop => "title"}) do
              @breadcrumbs.last.first
            end
          end
        end
      end
    end
  end
end
