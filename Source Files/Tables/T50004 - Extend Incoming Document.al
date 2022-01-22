tableextension 50004 ExtendIncomingDocument extends "Incoming Document"
{
    fields
    {
        field(50000; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}