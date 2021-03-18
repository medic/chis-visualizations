class TransformationProcessor:

    def __call__(self, source_col_details, target_col_details):
        self.source_col_details = source_col_details
        self.target_col_details = target_col_details
        return self

