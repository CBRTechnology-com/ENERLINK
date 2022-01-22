pageextension 50111 "Extend Item Card" extends "Item Card"
{
    layout
    {
        addafter("SAT Item Classification")
        {
            field("Visible on WebStore"; "Visible on WebStore")
            {
                ApplicationArea = All;
                Caption = 'Visible on WebStore';
            }
            field("Visible on Orbis"; "Visible on Orbis")
            {
                ApplicationArea = All;
                Caption = 'Visible on Orbis';
            }
        }
        addafter("Qty. on Sales Order")
        {
            field("Qty. on Sales Quote"; "Qty. on Sales Quote")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}