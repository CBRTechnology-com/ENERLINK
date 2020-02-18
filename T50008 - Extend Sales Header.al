tableextension 50008 ExtendsSalesHeader extends "Sales Header"
{
    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                "Tax Liable" := true;
            end;
        }
    }

    var
        myInt: Integer;

    trigger OnAfterInsert()
    begin
        "Tax Liable" := true;
    end;
}