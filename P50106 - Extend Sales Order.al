pageextension 50106 ExtendSalesOrder extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore("Pick Instruction")
        {

            action("Packing Slip")
            {
                ApplicationArea = All;
                Caption = 'Packing Slip';
                Image = Print;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Category11;
                trigger OnAction()
                begin
                    DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                end;
            }


        }
        modify("Pick Instruction")
        {
            ApplicationArea = all;
            Visible = false;
            Promoted = true;
            PromotedCategory = Category11;

        }

    }

    var
        myInt: Integer;
        DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
}