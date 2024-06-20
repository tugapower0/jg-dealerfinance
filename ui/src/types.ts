interface CircularProgressProps {
    value: number;
    max: number;
  }

  interface Vehicle {
    model: string;
    plate: string;
    paid?: number;
    total?: number;
    totalpayments?: number; // Total amount of payments
    paidpayments?: number; // Amount per payment
    perpayments?: number; // Next payment amount
    open?: boolean;
  }