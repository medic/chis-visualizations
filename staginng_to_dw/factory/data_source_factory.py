from factory import objectfactory_with_parms
from processor import sourceprocessor as sp


class DataSourceFactory(objectfactory_with_parms.ObjectFactory):
    def get(self, source_type, **kwargs):
        return self.create(source_type, **kwargs)


data_source_factory = DataSourceFactory()
data_source_factory.register_builder("postgresql", sp.ReadPostgresql())
