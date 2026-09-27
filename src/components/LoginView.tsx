import React from 'react';

export const LoginView: React.FC<any> = ({ reps = [], onSelectRep }) => {
  return (
    <div className="min-h-screen bg-slate-900 text-white flex flex-col items-center justify-center p-4">
      <div className="max-w-md w-full bg-slate-800 p-8 rounded-3xl space-y-4">
        <h2 className="text-lg font-black text-center">تسجيل الدخول - نظام إدارة الأقساط</h2>
        <div className="space-y-2">
          {reps.map((rep: any) => (
            <button
              key={rep.id}
              onClick={() => onSelectRep(rep)}
              className="w-full py-3 px-4 rounded-2xl bg-slate-700 hover:bg-indigo-600 text-right font-extrabold text-xs transition-all"
            >
              {rep.name}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};
