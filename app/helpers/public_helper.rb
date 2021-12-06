module PublicHelper
	QLINKS = {}
	def links(name = nil, options = nil, html_options = nil, &block)
		q = PublicHelper::QLINKS
		return link_to name, q[options] if q.keys.include? options
		link_to name, options, html_options
	end
	def register_link(name = nil, url = nil)
		QLINKS[name] = url
	end
end
