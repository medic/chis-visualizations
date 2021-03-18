import objectfactory_with_parms
import processor.transformationprocessor as transform


class DataTransformer(objectfactory_with_parms.ObjectFactory):
    def get(self, transformation_type, **kwargs):
        return self.create(transformation_type, **kwargs)


transformer_factory = DataTransformer()
transformer_factory.register_builder("copy", transform.Copy())
transformer_factory.register_builder("transpose_column_name_to_row", transform.TransformColumnToRow())
