tableextension 50005 ExtendReservationEntry extends "Reservation Entry"
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