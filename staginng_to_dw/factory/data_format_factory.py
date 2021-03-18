from factory import objectfactory_with_parms
from jsonprocessor import JsonSimpleProcessor, \
    JsonNormalizeProcessor, \
    ListAsJsonProcessor, \
    ScalarValuesAsJson


class DataFormatFactory(objectfactory_with_parms.ObjectFactory):
    def get(self, data_format, **kwargs):
        return self.create(data_format, **kwargs)


data_formatter_factory = DataFormatFactory()
#data_formatter_factory.register_builder("csv", CsvProcessor())
data_formatter_factory.register_builder("json", JsonSimpleProcessor())