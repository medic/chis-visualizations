class ResponseProcessor:

    def __call__(self, data):
        self.data = data
        #self.data_delimiter = data_delimiter
        return self

    def load_to_dataframe(self):
        pass
