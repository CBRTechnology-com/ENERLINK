page 50115 "Purchase Lines with Recpt Date"
{
    ApplicationArea = All;
    Caption = 'Purchase Lines';
    Editable = false;
    PageType = List;
    DelayedInsert = true;
    RefreshOnActivate = true;
    SourceTable = "Purchase line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(control)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                    Editable = false;
                    Visible = true;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Editable = false;
                    Visible = true;
                }
                field("Vendor ID"; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Buy-from Vendor No.';
                    Editable = false;
                    Visible = true;

                }
                field("Vendor Name"; VendorName)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    Editable = false;
                    Visible = true;

                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = false;
                    Visible = true;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    Editable = false;
                    Visible = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = false;
                    Visible = true;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code';
                    Editable = false;
                    Visible = true;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    Editable = false;
                    Visible = true;
                }
                field("Reserved Qty. (Base)"; "Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                    Caption = 'Reserved Qty. (Base)';
                    Editable = false;
                    Visible = true;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Unit of Measure';
                    Editable = false;
                    Visible = true;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Direct Unit Cost';
                    Editable = false;
                    Visible = true;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Line Amount';
                    Editable = false;
                    Visible = true;
                }

                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    Caption = 'Expected Receipt Date';
                    Editable = false;
                    Visible = true;
                }
                field("Qty Remaining"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Outstanding Quantity';
                    Editable = false;
                    Visible = true;
                }

            }
        }
    }

    actions
    {
    }


    trigger OnAfterGetRecord()
    var
        Recvendor: Record Vendor;

    begin
        if Recvendor.get(rec."Buy-from Vendor No.") then
            VendorName := Recvendor.Name;
    end;

    trigger OnOpenPage()
    var
    begin
        SetRange("Document Type", "Document Type"::Order);
    end;

    var
        VendorName: Text[100];

}