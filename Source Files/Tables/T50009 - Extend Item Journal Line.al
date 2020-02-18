tableextension 50009 ExtendItemJournalLine extends "Item Journal Line"
{
    fields
    {
        field(50000; "Item Substitute"; Code[20])
        {
            Caption = 'Item Substitute';
            ObsoleteState = Removed;
        }
    }

    var
        myInt: Integer;
}