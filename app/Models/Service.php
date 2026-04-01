<?php

namespace App\Models;

use App\Models\Admin\Product;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function getStatusTextAttribute()
    {
        // status 0 = pending, 1 = completed
        if ((string) $this->status === '1') {
            return 'Completed';
        }

        return 'Pending';
    }

    public function getStatusBadgeAttribute()
    {
        $text = $this->status_text;
        $class = (string) $this->status === '1' ? 'success' : 'warning';

        return "<span class='badge bg-{$class}'>{$text}</span>";
    }
}
