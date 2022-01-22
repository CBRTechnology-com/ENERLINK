tableextension 50006 ExtendTrackingSpecification extends "Tracking Specification"
{
    fields
    {
        field(50000; "Purity(%)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50001; QC; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}