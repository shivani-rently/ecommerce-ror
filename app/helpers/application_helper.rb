module ApplicationHelper
    def active_class(path)
        if request.fullpath == path
            return 'active'
        else
            return ''
        end
    end
end
