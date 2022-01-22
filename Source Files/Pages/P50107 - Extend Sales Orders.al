pageextension 50107 ExtendSalesOrders extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst("&Print")
        {

            action("Packing Slip")
            {
                ApplicationArea = All;
                Caption = 'Packing Slip';
                Image = Print;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                end;
            }


        }
    }

    var
        myInt: Integer;
        DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";


}