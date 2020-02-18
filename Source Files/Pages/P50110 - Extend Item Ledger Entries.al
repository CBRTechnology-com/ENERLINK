pageextension 50110 ExtendItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Source No."; "Source No.")
            {
                ApplicationArea = All;
                Caption = 'Source No.';
            }
            field("Source Name"; "Source Name")
            {
                ApplicationArea = All;
                Caption = 'Source Name';
            }
            field("Sales Order No."; "Sales Order No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Order No.';
            }
            field("External Document No."; "External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Doc Number';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnAfterGetRecord()
    begin
        GetSourceName();
        GetSalesOrderNo();
    end;
}