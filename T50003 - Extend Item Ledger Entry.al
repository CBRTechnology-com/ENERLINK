tableextension 50003 ExtendItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50001; "Purity(%)"; Decimal)
        {
            Caption = 'Purity(%)';
        }
        field(50002; QC; Boolean)
        {
            Caption = 'QC';
        }
        field(50003; LOD; Decimal)
        {
            Caption = 'LOD';
        }
    }

    var
        myInt: Integer;
}