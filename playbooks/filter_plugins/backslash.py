class FilterModule(object):
    def filters(self):
        return {'backslash': self.backslash}

    def backslash(self, string):
        if isinstance(string, str):
            return string.replace('/', '\\')
        return string
