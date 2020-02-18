tableextension 50012 ExtendItemSubstitution extends "Item Substitution"
{
    fields
    {
        field(50000; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
    }

    var
        myInt: Integer;

    procedure SetSalesOrderNo(var OrderNo: Code[20])
    begin
        "Document No" := OrderNo;
    end;
}