<?php

use App\Models\Booking;
use App\Models\Notification;
use App\Models\User;
use App\Models\Admin\Currency;
use App\Models\Admin\ProductImage;
use App\Models\Admin\ProductOptionTopping;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;

// Load modular helper sub-files
require_once __DIR__ . '/CartHelper.php';
require_once __DIR__ . '/LibraryHelper.php';
require_once __DIR__ . '/FormatHelper.php';

if (!function_exists('pendingBooking')) {
    function pendingBooking()
    {
        return Booking::count();
    }
}

if (!function_exists('getProductImage')) {
    function getProductImage($id)
    {
        return ProductImage::where('product_id', $id)->get();
    }
}

if (!function_exists('getStatus')) {
    function getStatus()
    {
        return [
            0 => 'Inactive',
            1 => 'Active',
        ];
    }
}

if (!function_exists('getAmountType')) {
    function getAmountType()
    {
        return [
            1 => 'Percentage',
            0 => 'Direct',
        ];
    }
}

if (!function_exists('getUser')) {
    function getUser($id)
    {
        return User::where('id', $id)->pluck('name')->first();
    }
}

if (!function_exists('getUserPhone')) {
    function getUserPhone($id)
    {
        return User::where('id', $id)->pluck('phone')->first();
    }
}

if (!function_exists('orderStatuses')) {
    function orderStatuses()
    {
        return [
            '1' => 'Pending',
            '2' => 'Processing',
            '3' => 'Shipped',
            '4' => 'Out for Delivery',
            '5' => 'Delivered',
            '6' => 'Canceled',
            '7' => 'Backordered',
            '8' => 'Returned',
            '9' => 'Refunded',
        ];
    }
}

if (!function_exists('orderStatusTitle')) {
    function orderStatusTitle()
    {
        return [
            1 => 'অর্ডারটি কনফার্মেশনের জন্য অপেক্ষমাণ। শীঘ্রই আমাদের একজন প্রতিনিধি এসএমএস বা ফোন কলের মাধ্যমে অর্ডারটি কনফার্ম করবেন ইন-শা-আল্লাহ।',
            2 => 'অর্ডারটি প্রক্রিয়াকরণে রয়েছে এবং প্রস্তুতির কাজ চলছে।',
            3 => 'আপনার অর্ডারটি পাঠানো হয়েছে এবং এটি পথে রয়েছে। শীঘ্রই আপনি এটি পেয়ে যাবেন।',
            4 => 'অর্ডারটি ডেলিভারির জন্য রওনা হয়েছে। দয়া করে প্রস্তুত থাকুন।',
            5 => 'অর্ডারটি সফলভাবে ডেলিভারি করা হয়েছে। আমাদের সেবা ব্যবহারের জন্য ধন্যবাদ।',
            6 => 'দুঃখিত, আপনার অর্ডারটি বাতিল করা হয়েছে। কোনো প্রশ্ন থাকলে আমাদের সাথে যোগাযোগ করুন।',
            7 => 'এই পণ্যটি স্টকে নেই এবং ব্যাকঅর্ডার হিসাবে রাখা হয়েছে। স্টকে এলে শীঘ্রই আপনাকে জানানো হবে।',
            8 => 'আপনার অর্ডারটি ফেরত দেওয়া হয়েছে এবং প্রক্রিয়াকরণে রয়েছে। ধন্যবাদ।',
            9 => 'আপনার অর্থ ফেরত দেওয়া হয়েছে। দয়া করে ২-৩ কার্যদিবস অপেক্ষা করুন।',
        ];
    }
}

if (!function_exists('currecySymbleType')) {
    function currecySymbleType()
    {
        return [
            '1' => 'Prefix',
            '2' => 'Suffix',
        ];
    }
}

if (!function_exists('getCurrency')) {
    function getCurrency()
    {
        return Currency::where('status', '1')->pluck('symbol')->first();
    }
}

if (!function_exists('shceduleTypes')) {
    function shceduleTypes()
    {
        return [
            'Delivery' => 'Delivery',
            'Dining room and pick-up' => 'Dining room and pick-up',
        ];
    }
}

if (!function_exists('userTypes')) {
    function userTypes()
    {
        return [
            '1' => 'Super Admin',
            '2' => 'Customer',
            '3' => 'Delivery Boy',
        ];
    }
}

if (!function_exists('getNotifications')) {
    function getNotifications()
    {
        return Notification::where('status', '1')->orderBy('created_at', 'DESC')->get();
    }
}

if (!function_exists('unSeenNotifications')) {
    function unSeenNotifications()
    {
        return Notification::where('status', '1')->where('isSeen', '0')->count();
    }
}

if (!function_exists('sendEmployeeCredential')) {
    function sendEmployeeCredential($data)
    {
        $recipientEmail = $data['email'] ?? config('mail.from.address');
        $companyName  = config('app.name', 'Company Name');
        $companyEmail = config('mail.from.address', 'noreply@example.com');

        Mail::send('emails.employee', ['data' => $data], function ($m) use ($data, $recipientEmail, $companyEmail, $companyName) {
            $m->from($companyEmail, 'Credentials of ' . $companyName);
            $m->to($recipientEmail)->subject('HRIS Access Information');
        });
    }
}

if (!function_exists('getSelectedTopings')) {
    function getSelectedTopings($id)
    {
        return ProductOptionTopping::join('topings', 'topings.id', '=', 'product_option_toppings.topping_id')
            ->select('topings.*')
            ->where('product_option_toppings.product_option_id', $id)
            ->get();
    }
}

if (!function_exists('getHost')) {
    function getHost()
    {
        $host = request()->getHost();
        return str_replace('www.', '', $host);
    }
}

if (!function_exists('getRootURL')) {
    function getRootURL()
    {
        $currentUrl = request()->url();
        $parsed_url = parse_url($currentUrl);
        $host = $parsed_url['host'];
        $port = isset($parsed_url['port']) ? $parsed_url['port'] : null;
        return $port !== null ? $host . ':' . $port : $host;
    }
}

if (!function_exists('checkRole')) {
    function checkRole()
    {
        $user = Auth::user();
        return $user ? $user->getRoleNames()[0] ?? null : null;
    }
}

if (!function_exists('paymentMethods')) {
    function paymentMethods()
    {
        return [
            '1' => 'Cash Payment',
            '2' => 'Card Payment',
            '3' => 'Other Payment',
        ];
    }
}

if (!function_exists('attendanceStatus')) {
    function attendanceStatus()
    {
        return [
            '1' => 'Present',
            '2' => 'Absent',
            '3' => 'Leave',
        ];
    }
}
